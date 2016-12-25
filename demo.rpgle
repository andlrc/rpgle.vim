/include a,b
/include c,d

dcl-ds abc likeds(def);
dcl-s a varchar(32);

a = %char(a, b);
b = %not_found(a);
c = found(hello);

dcl-proc a;
  dcl-pi *n int(1);
    qwerty likeds(hello);
  end-pi;

  return *OFF;
end-proc;

dcl-pr hello;
  world ind;
end-pr;

dcl-ds a;
  a varchar(1);
end-ds;

a = *INRT;

begsr a;
  hello();
endsr;

select;
  when a = 1;
    monitor;
      a = 1 / 0;
    on-error;
      hello();
    endmon;

    doA();
    b = *NULL;

  when b = 1;
    doB();

  other;
    doC();
endsl;

dow a < 4;
  b();
  c = *OFF;
enddo;

exec SQL declare parents cursor for pParent;
exec sql select abs(abc), def from qwer;

dcl-proc b;
  dcl-pi *n;
    a varchar(32);
  end-pi;

  hello();

end-proc;

dcl-proc c;
  dcl-pi *n;
  end-pi;

  hello();

end-proc;

for i = 1 to 10;
  doFor();
endfor;

if a = 1;
  if b = 1;
    doAB();
  // if
  else;
    doNOTABC():
  endif;
else;
  doQQ();
endif;
