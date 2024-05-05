
int med3(int a, int b, int c) {
  int mid;
  if ( a > b )   {
    if ( c > b) {
	if ( c < a )
	  mid = c;
	else
	  mid = a;
    }
    else {
      mid = b;
    }
  }
  else {
    if ( b > c ) {
	if  ( a > c)
	  mid = a;
	else
	  mid = c;
    }
    else {
      mid = b;
    }
  }
  return mid ;
}
