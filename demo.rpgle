begsr a;
  hello();
endsr;

select;
  when a = 1;
    doA();
  when b = 1;
    doB();
  other;
    doC();
endsl;

exec SQL declare parents cursor for pParent;
exec sql select abs(abc), def from qwer;

dcl-proc a;
  dcl-pi *n;
    a varchar(32);
  end-pi;

  hello();

end-proc;

dcl-proc a;
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
  else;
    doNOTABC():
  endif;
else;
  doQQ();
endif;
