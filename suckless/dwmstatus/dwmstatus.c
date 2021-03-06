#define _BSD_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <strings.h>
#include <sys/time.h>
#include <time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/sysinfo.h>
#include <unistd.h>

#include <X11/Xlib.h>

char *tzbel = "Europe/Minsk";
const char* BATSTAT = "/sys/class/power_supply/BAT0/status";
const char* BATFULL = "/sys/class/power_supply/BAT0/energy_full";
const char* BATNOW = "/sys/class/power_supply/BAT0/energy_now";

static Display *dpy;

char *
smprintf(char *fmt, ...)
{
    va_list fmtargs;
    char *ret;
    int len;

    va_start(fmtargs, fmt);
    len = vsnprintf(NULL, 0, fmt, fmtargs);
    va_end(fmtargs);

    ret = malloc(++len);
    if (ret == NULL) {
        perror("malloc");
        exit(1);
    }

    va_start(fmtargs, fmt);
    vsnprintf(ret, len, fmt, fmtargs);
    va_end(fmtargs);

    return ret;
}

void
settz(char *tzname)
{
    setenv("TZ", tzname, 1);
}

char *
mktimes(char *fmt, char *tzname)
{
    char buf[129];
    time_t tim;
    struct tm *timtm;

    memset(buf, 0, sizeof(buf));
    settz(tzname);
    tim = time(NULL);
    timtm = localtime(&tim);
    if (timtm == NULL) {
        perror("localtime");
        exit(1);
    }

    if (!strftime(buf, sizeof(buf)-1, fmt, timtm)) {
        fprintf(stderr, "strftime == 0\n");
        exit(1);
    }

    return smprintf("%s", buf);
}

void
setstatus(char *str)
{
    XStoreName(dpy, DefaultRootWindow(dpy), str);
    XSync(dpy, False);
}

char *
loadavg(void)
{
    long double a[4], b[4], loadavg;
    FILE *fp;
    fp = fopen("/proc/stat","r");
    fscanf(fp,"%*s %Lf %Lf %Lf %Lf",&a[0],&a[1],&a[2],&a[3]);
    fclose(fp);
    sleep(1);
    fp = fopen("/proc/stat","r");
    fscanf(fp,"%*s %Lf %Lf %Lf %Lf",&b[0],&b[1],&b[2],&b[3]);
    fclose(fp);
    loadavg = ((b[0]+b[1]+b[2]) - (a[0]+a[1]+a[2])) / ((b[0]+b[1]+b[2]+b[3]) - (a[0]+a[1]+a[2]+a[3]));
    return smprintf("%.2Lf", loadavg * 100);
}

char *
memory(void)
{
    struct sysinfo myinfo;
    sysinfo(&myinfo);
    long double total_bytes = myinfo.mem_unit * myinfo.totalram;
    long double used_bytes = total_bytes - myinfo.freeram * myinfo.mem_unit;
    return smprintf("%.2Lf GB / %.2Lf GB",
         used_bytes/1024/1024/1024, total_bytes/1024/1024/1024);
}

char *
d_bar(int p)
{
    char *s[] = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█", "█" };
    return s[((8 * p) / 100)];
}

char *
battery(void)
{
    if(access( BATSTAT, F_OK ) != -1) {
        char stat[12];
        int now = 0;
        int full = 0;
        FILE* batst = fopen(BATSTAT, "r");
        fscanf(batst, "%s", stat);
        fclose(batst);
        FILE* batnow = fopen(BATNOW, "r");
        fscanf(batnow, "%d", &now);
        fclose(batnow);
        FILE* batfull = fopen(BATFULL, "r");
        fscanf(batfull, "%d", &full);
        fclose(batfull);
        double bat = 100 * ((double)now / full);
        char* baticon = d_bar(bat);

        if (strncmp(stat, "Discharging", 11)) {
            return smprintf("⚡ %s %.0f", baticon, bat);
        }
        else
            return smprintf("%s %.0f", baticon, bat);
    } else {
        return smprintf("⚡");
    }
}

int
main(void)
{
    char *status;
    char *avgs;
    char *tbel;
    char *dbel;
    char *mem;
    char *bat;

    if (!(dpy = XOpenDisplay(NULL))) {
        fprintf(stderr, "dwmstatus: cannot open display.\n");
        return 1;
    }
    for (;;sleep(1)) {
        avgs = loadavg();
        tbel = mktimes("%H:%M", tzbel);
        dbel = mktimes("%d-%m-%Y", tzbel);
        mem = memory();
        bat = battery();
        status = smprintf(" B: %s%  M: %s  C: %s%  %s  %s",
                bat, mem, avgs, dbel, tbel);
        setstatus(status);
        free(avgs);
        free(tbel);
        free(dbel);
        free(bat);
        free(mem);
        free(status);
    }

    XCloseDisplay(dpy);

    return 0;
}

