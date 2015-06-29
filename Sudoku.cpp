#include <iostream>
using namespace std;

static int tu[9][9] = {{0, 0, 0, 0, 0, 0, 6, 0, 0},
                       {2, 3, 0, 0, 0, 0, 0, 0, 0},
                       {0, 0, 0, 0, 0, 0, 9, 0, 0},
                       {0, 0, 6, 0, 0, 7, 0, 0, 0},
                       {5, 0, 0, 2, 0, 0, 0, 3, 0},
                       {0, 0, 0, 0, 0, 0, 0, 1, 0},
                       {0, 0, 7, 0, 6, 9, 0, 0, 0},
                       {0, 1, 0, 0, 0, 0, 0, 2, 5},
                       {0, 0, 0, 0, 0, 8, 0, 0, 0}};

int isvalid(const int i, const int j)
{
	const int n = tu[i][j];
	const static int query[] = {0, 0, 0, 3, 3, 3, 6, 6, 6};
	int t, u;

	for (t = 0; t < 9; t++)
		if (t != i && tu[t][j] == n || t != j && tu[i][t] == n)
			return 0;

	for (t = query[i]; t < query[i] + 3; t++)
		for (u = query[j]; u < query[j] + 3; u++)
			if ((t != i || u != j) && tu[t][u] == n)
				return 0;

    return 1;
}

void output()
{
	static int n;

	cout << "Ω‚∑® " << ++n << ":" <<endl;

	for (int i = 0; i < 9; i++) {
		for (int j = 0; j < 9; j++)
			cout<< tu[i][j] << " ";
		cout << endl;
	}

	cout << endl;
}

void solve(const int n)//∫À–ƒ∫Ø ˝£¨ªÿÀ›À„∑®
{
	if (n == 81) {// «∑Ò“—æ≠ «◊Ó∫Û“ª∏ˆ∏Ò◊”
		output();
		return;
	}

	const int i = n / 9, j = n % 9;

	if (tu[i][j] != 0) {
		solve(n + 1);
		return;
	}

	for (int k = 0; k < 9; k++) {
		tu[i][j]++;
		if (isvalid(i, j))
			solve(n + 1);
	}

	tu[i][j] = 0;
}

int main()
{

	solve(0);

	getchar();
	return 0;
}
