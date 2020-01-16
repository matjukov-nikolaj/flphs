% описываем животных
  animal('пингвин'):-positive('плавает'),positive('имеет окраску'),
                     negative('приручено человеком'),
                     negative('умеет летать'),is('птица').

  animal('гусь'):-positive('плавает'),positive('имеет окраску'),
                  positive('приручено человеком'),
                  positive('умеет летать'),is('птица').

  animal('дикая утка'):-positive('плавает'),positive('имеет окраску'),
                        negative('приручено человеком'),
                        positive('умеет летать'),is('птица').

  animal('страус'):-negative('плавает'),positive('имеет окраску'),
                    negative('приручено человеком'),
                    negative('умеет летать'),is('птица').

  animal('стриж'):-negative('плавает'),positive('имеет окраску'),
                   negative('приручено человеком'),
                   positive('умеет летать'),is('птица').

  animal('соловей'):-negative('плавает'),positive('имеет окраску'),
                     negative('приручено человеком'),
                     positive('умеет летать'),is('птица').

  animal('щегол'):-negative('плавает'),positive('имеет окраску'),
                   negative('приручено человеком'),
                   positive('умеет летать'),is('птица').

  animal('волнистый попугайчик'):-negative('плавает'),
                   positive('имеет окраску'),
                   positive('приручено человеком'),
                   positive('умеет летать'),is('птица').

  animal('заяц'):-positive('плавает'),positive('имеет окраску'),
                  negative('умеет летать'),
                  positive('имеет большие когти и зубы'),
                  negative('приручено человеком'),
                  is('млекопитающее').

  animal('крот'):-negative('умеет летать'),negative('имеет окраску'),
                  positive('имеет большие когти и зубы'),
                  negative('приручено человеком'),
                  negative('плавает'),positive('слепое от рождения'),
                  is('млекопитающее').

  animal('зебра'):-negative('умеет летать'),positive('имеет окраску'),
                   negative('имеет большие когти и зубы'),
                   positive('имеет рога'),
                   negative('приручено человеком'),
                   positive('плавает'),is('млекопитающее'),
                   is('парнокопытное').

  animal('корова'):-negative('умеет летать'),positive('имеет окраску'),
                    negative('имеет большие когти и зубы'),
                    positive('имеет рога'),
                    positive('приручено человеком'),
                    positive('плавает'),is('млекопитающее'),is('парнокопытное').

  animal('бобер'):-negative('умеет летать'),negative('имеет окраску'),
                  positive('имеет большие когти и зубы'),
                  negative('приручено человеком'),
                  positive('плавает'),is('млекопитающее').

  animal('волк'):-negative('умеет летать'),negative('имеет окраску'),
                  positive('имеет большие когти и зубы'),
                  negative('приручено человеком'),
                  positive('плавает'),is('хищник').

  animal('тигр'):-negative('умеет летать'),positive('имеет окраску'),
                  positive('имеет большие когти и зубы'),
                  negative('приручено человеком'),
                  positive('плавает'),is('хищник').

  animal('слон'):-negative('умеет летать'),negative('имеет окраску'),
                  negative('имеет большие когти и зубы'),
                  positive('приручено человеком'),
                  positive('плавает'),is('млекопитающее'),is('парнокопытное').

  animal('людоед'):-negative('умеет летать'),negative('имеет окраску'),
                  negative('имеет большие когти и зубы'),
                  negative('приручено человеком'),
                  positive('плавает'),is('хищник').

  animal('неизвестное создание с далекой планеты ...').

%-----------------------------------------------------------------------------
  is('птица'):-positive('откладывает яйца'),!;
               positive('имеет оперение').
  is('хищник'):-positive('живородящее'),!;
                negative('поедает траву и кустарники'),
                positive('поедает других животных').
  is('млекопитающее'):-positive('живородящее'),!;
                       positive('поедает траву и кустарники'),
                       negative('поедает других животных').
  is('парнокопытное'):-positive('имеет копыта').
%-----------------------------------------------------------------------------
% работа с динамической базой данных
  positive(X):-xpositive(X),!; xnegative(X),!,fail; ask(X,'y').
  negative(X):-xnegative(X),!; xpositive(X),!,fail; ask(X,'n').
  ask(X,R):-write(X),write('  ?  : '),read(Reply),write(Reply),nl,
            remember(X,Reply),R=Reply.
% проверка присутствия фактов в динамической базе данных
  xpositive(X):-yes(X);maybe(X).
  xnegative(X):-no(X);maybe(X).
% запоминаем факт в динамической базе данных
  remember(X,'y'):-asserta(yes(X)).
  remember(X,'n'):-assertz(no(X)).
  remember(X,'q'):-asserta(maybe(X)).
% очищаем память от фактов динамической базы данных
delete_all:-retract(yes(_)),delete_all.
delete_all:-retract(no(_)),delete_all.
delete_all:-retract(maybe(_)),delete_all.
delete_all.
%-----------------------------------------------------------------------------
 

 run:-delete_all,
       write('На вопросы отвечать (y-да, n-нет, q-не знаю).'),nl,
       animal(X),
       write('Это животное : '),write(X),nl.