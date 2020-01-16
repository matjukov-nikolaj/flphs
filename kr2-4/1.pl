%1 задание
surname("Kuznecov").
surname("Tokarev").
surname("Slesarev").
surname("Rezchikov").

profession("Kyznec").
profession("Tokar").
profession("Slesar").
profession("Rezchik").

notWorker("Kyznecov", "Kyznec").
notWorker("Tokarev", "Tokar").
notWorker("Slesarev", "Slesar").
notWorker("Rezchikov", "Rezchik").

opposite("Kyznecov","Slesar").
opposite("Rezchikov","Rezchik").
opposite(N,P):-N\="Kyznecov", P\="Slesar", N\="Rezchikov", P\="Rezchik".

left("Slesarev","Tokar").
left(N,P):-N\="Slesarev", P\="Tokar".

generatePairs(N0,P0,N1,P1,N2,P2,N3,P3):-  N0="Kyznecov", profession(P0), not(notWorker(N0,P0)),
                                    surname(N1), N1\=N0, profession(P1), P1\=P0, not(notWorker(N1,P1)),
                            surname(N2), N2\=N0, N2\=N1, profession(P2), P2\=P0, P2\=P1, not(notWorker(N2,P2)),
                    surname(N3), N3\=N0, N3\=N1, N3\=N2, profession(P3), P3\=P0, P3\=P1, P3\=P2, not(notWorker(N3,P3)).

checkPairs(N0,P0,N1,P1,N2,P2,N3,P3):-opposite(N0,P2), opposite(N1,P3), opposite(N2,P0), opposite(N3,P1),
                                        left(N0,P1), left(N1,P2), left(N2,P3), left(N3,P0).

findLeft(N0,P1,N0,_,_,P1,_,_,_,_).
findLeft(N1,P2,_,_,N1,_,_,P2,_,_).
findLeft(N2,P3,_,_,_,_,N2,_,_,P3).
findLeft(N3,P0,_,P0,_,_,_,_,N3,_).

soultion(X, Y):-generatePairs(N0,P0,N1,P1,N2,P2,N3,P3), checkPairs(N0,P0,N1,P1,N2,P2,N3,P3), findLeft(X,Y,N0,P0,N1,P1,N2,P2,N3,P3).