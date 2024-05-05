int max(int a, int b) {
  if (a>b) return a;
  else return b;
}

void select (int *a, int *b, int len) {

  for (int i=0; i<len; i++) {
    a[i] = max(a[i], b[i]);
  }

}
