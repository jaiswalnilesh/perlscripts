#include <stdio.h>
#include <stdlib.h>

struct node {
        int data;
        struct node *next;
};

typedef struct node NODE;

int main()
{
        NODE *p;
        p=NULL;

        append(&p, 1);
        append(&p, 2);
        append(&p, 3);
        append(&p, 4);
        append(&p, 5);
        append(&p, 6);
        append(&p, 7);
        display(&p);
        addatbeg(&p, 01);
        addatbeg(&p, 02);
        display(&p);
}


append(NODE *p, int num)
{
        NODE *temp, *r;
        temp=p;
        if (temp == NULL)
                temp=(NODE *)malloc(sizeof(NODE));
                temp->data=num;
                temp->next=NULL;
                p=temp;
        }
        else
        {
                temp=p;
                while(temp->next != NULL)
                        temp=temp->next;
                r=(NODE *)malloc(sizeof(NODE));
                r->data=num;
                r->next=NULL;
                temp->next=r;
        }
}
