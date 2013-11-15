/*
@author Haochi Chen (http://ihaochi.com)
*/
Date.prototype.strftime = function(format){
  var strftime = function(b,c){return b.replace(/%([a-z%])/gi,function(a,b){return c[b];})},
      padded = function(number, padder, size){
        padder = padder || '0';
        size = size || 2;
        number = number.toString();
        while(number.length < size){
          number = padder + number;
        }
        return number;
      },
      MONTH_NAMES = ['January','February','March','April','May','June', 'July','August','September','October','November','December'],
      MONTH_NAMES_ABBR = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
      DAY_NAMES = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
      DAY_NAMES_ABBR = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      SECOND = this.getSeconds(),
      MINUTE = this.getMinutes(),
      HOUR = this.getHours(),
      HOUR_12 = HOUR > 12 ? HOUR - 12 : HOUR,
      AM_PM = HOUR > 0 && HOUR < 13 ? "AM" : "PM",
      DATE = this.getDate(),
      DAY = this.getDay(),
      MONTH = this.getMonth(),
      FULL_YEAR = this.getFullYear(),
      YEAR = parseInt(FULL_YEAR.toString().substring(2)),
      H_M = [padded(HOUR), padded(MINUTE)].join(":"),
      H_M_S = [H_M, padded(SECOND)].join(":"),
      m_d = [padded(MONTH + 1), padded(DATE)].join("/"),
      TIME_ZONE = this.toTimeString().match(/([\+-]\d+)\s+\((\w+)\)/),
      FIRST_MONDAY = this.getFirstWeekDayOfYear(1),
      FIRST_SUNDAY = this.getFirstWeekDayOfYear(0);

  return strftime(format, {
    a: DAY_NAMES_ABBR[DAY],
    A: DAY_NAMES[DAY],
    b: MONTH_NAMES_ABBR[MONTH],
    B: MONTH_NAMES[MONTH],
    c: strftime("%a %b %d %T %Y", {
      a: DAY_NAMES_ABBR[DAY],
      b: MONTH_NAMES_ABBR[MONTH],
      d: padded(DATE),
      T: H_M_S,
      Y: FULL_YEAR
    }),
    C: Math.floor(FULL_YEAR/100),
    d: padded(DATE),
    D: strftime("%m/%y", { m: m_d, y: YEAR }),
    e: DATE,
    F: strftime("%Y-%m", { m: m_d.replace("/", "-"), Y: FULL_YEAR }),
 // g: '',
 // G: '',
    h: MONTH_NAMES_ABBR[MONTH],
    H: padded(HOUR),
    I: padded(HOUR_12),
    j: padded(Math.ceil((this - new Date(FULL_YEAR, 0, 1))/86400000) + 1, '0', 3),
    k: padded(HOUR, ' '),
    l: padded(HOUR_12, ' '),
    m: padded(MONTH+1),
    M: padded(MINUTE),
    n: "\n",
    p: AM_PM,
    P: AM_PM.toLowerCase(),
    r: strftime("%I:%M:%S %p", {I: padded(HOUR_12), M: padded(MINUTE), S: padded(SECOND), p: AM_PM}),
    R: H_M,
    s: Math.floor(this.getTime()/1000),
    S: padded(SECOND),
    t: "\t",
    T: H_M_S,
    u: !DAY ? 7 : DAY,
    U: Math.ceil((((this - FIRST_SUNDAY)/86400000) + 1)/7),
 // v: '0',
 // V: '0',
    w: DAY,
    W: Math.ceil((((this - FIRST_MONDAY)/86400000) + 1)/7),
    x: this.toLocaleDateString(),
    X: this.toLocaleTimeString(),
    y: YEAR,
    Y: FULL_YEAR,
    z: TIME_ZONE ? TIME_ZONE[1] : "",
    Z: TIME_ZONE ? TIME_ZONE[2] : "",
    '%': '%'
  });
};

Date.strftime = function(format){
  return (new Date).strftime(format);
};

Date.prototype.getFirstWeekDayOfYear = function(day){
  /* Given a number (0-6 representing Sunday-Saturday)
     it will return the first weekday of the year
     that you asked for. */
  var date = new Date(this.getFullYear(), 0, 1);
  if(date.getDay() != day){
    date.setDate(date.getDate() + day - date.getDay());
    if(date.getFullYear() != this.getFullYear()){
      date.setDate(date.getDate() + 7);
    }
  }
  return date;
}
