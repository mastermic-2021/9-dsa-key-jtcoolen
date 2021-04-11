dsa_pub = [Mod(16, 2359457956956300567038105751718832373634513504534942514002305419604815592073181005834416173), 589864489239075141759526437929708093408628376133735628500576354901203898018295251458604043, 2028727269671031475103905404250865899391487240939480351378663127451217489613162734122924934];
check(s,dsa_pub) = {
  my(h,r,g,q,X);
  [h,r,s] = s;
  [g,q,X] = dsa_pub;
  X = Mod(X, g.mod);
  lift( (g^h*X^r)^(1/s % q) ) % q == r;
}

\\ mod q: s=k^(-1) ( h(m) + x*r) => x = (k*s - h(m)) * r^(-1)
extract_key(sig, k) = {
  [h,r,s] = sig;
  \\print(h, r, s);
  lift( ( (k * s - h) * (1/Mod(r, q)) ) ) % q;
}

sigs = readvec("input.txt");
[g,q,X] = dsa_pub;
lookup = Map();

\\ Insertion des r_i
for(i=1, #sigs, [h, r, s] = sigs[i]; mapput(lookup, r, sigs[i])); 

\\ On sait que k appartient à un intervalle plus petit que [1,q-1], permettant une attaque par force brute
\\ On va élever g à un entier k choisi aléatoirement dans l'intervalle [1,10^10] jusqu'à ce qu'une collision (g^k mod p) mod q == r_i pour un certain i ait lieu.
\\ En effet, l'entier r d'une signature DSA est donné par (g^k mod p) mod q pour un k aléatoire de l'intervalle ici [1,10^10].
while(1, k=random(10^10); res=lift(Mod(lift(g^k), q)); if(mapisdefined(lookup, res, &j), break));

\\ extraction de la clé privée
print(extract_key(j, k));
