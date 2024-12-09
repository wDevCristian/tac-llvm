#include <iostream>

class Dot
{
    private:
        int _x;
        int _y;

    public:
        int getX()
        {
            return _x;
        };
        int getY()
        {
            return _y;
        }

        Dot(int x, int y)
        {
            _x = x;
            _y = y;
        }
};

int main() {
    Dot d = Dot(10, 5);

    for (int i = 0; i < 10; i++)
    {
        std::cout << i << std::endl;
    }
     
    return 0;
}