dsa_pub = [Mod(16, 2359457956956300567038105751718832373634513504534942514002305419604815592073181005834416173), 589864489239075141759526437929708093408628376133735628500576354901203898018295251458604043, 2028727269671031475103905404250865899391487240939480351378663127451217489613162734122924934];
check(s,dsa_pub) = {
  my(h,r,g,q,X);
  [h,r,s] = s;
  [g,q,X] = dsa_pub;
  X = Mod(X, g.mod);
  lift( (g^h*X^r)^(1/s % q) ) % q == r;
}


signatures = readvec("input.txt");
print(length(signatures));
\\print(signatures[1]);
\\lookup = Map();
\\for(i = 1, #signatures, [h, r, s] = signatures[i]; if(mapisdefined(lookup, r, &j), print(r)); mapput(lookup, r, signatures[i]));
\\print(check(signatures[2], dsa_pub));
s1 = signatures[1];
s2 = signatures[2];
s3 = signatures[3];
print(check(s3, dsa_pub));


