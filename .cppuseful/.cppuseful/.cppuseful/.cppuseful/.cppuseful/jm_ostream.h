#ifndef JM_OSTREAM_H
#define JM_OSTREAM_H

#include <vector>
#include <map>
#include <iostream>
#include <list>
#include <set>
#include <unordered_set>

#include "jm_consts.h"

std::ostream& operator<<(std::ostream&, std::list<int>);
template <class T>
std::ostream& operator<<(std::ostream&, std::list<T>);
template <class F, class S>
std::ostream& operator<<(std::ostream&, std::map<F, S>);
template <class F, class S>
std::ostream& operator<<(std::ostream&, std::pair<F, S>);
template <class F, class S>
std::ostream& operator<<(std::ostream&, std::pair<F, S*>);
std::ostream& operator<<(std::ostream&, std::set<int>);
template <class T>
std::ostream& operator<<(std::ostream&, std::set<T>);
std::ostream& operator<<(std::ostream&, std::unordered_set<int>);
template <class T>
std::ostream& operator<<(std::ostream&, std::unordered_set<T>);
std::ostream& operator<<(std::ostream&, std::vector<int>);
template <class T>
std::ostream& operator<<(std::ostream&, std::vector<T>);

std::ostream& operator<<(std::ostream& out, std::list<int> l) {
    out << '[';
    if(l.size() > 0) {
        if(*l.begin() == INF) {
            out << "-";
        }
        else {
            out << *l.begin();
        }
        for(auto index = ++l.begin(); index != l.end(); index++) {
            if(*index == INF) {
                out << ", -";
            }
            else {
                out << ", " << *index;
            }
        }
    }
    return out << ']';
}
template <class T>
std::ostream& operator<<(std::ostream& out, std::list<T> l) {
    out << '[';
    if(l.size() > 0) {
        out << *l.begin();
        for(auto index = ++l.begin(); index != l.end(); index++) {
            out << ", " << *index;
        }
    }
    return out << ']';
}

template <class F, class S>
std::ostream& operator<<(std::ostream& out, std::map<F, S> m) {
    out << '{';
    if(m.size() > 0) {
        out << m.begin()->first << ": " << m.begin()->second;
        for(auto index = ++m.begin(); index != m.end(); index++) {
            out << ", " << index->first << ": " << index->second;
        }
    }
    return out << '}';
}

template <class F, class S>
std::ostream& operator<<(std::ostream& out, std::pair<F, S> p) {
    return out << '(' << p.first << ", " << p.second << ')';
}
template <class F, class S>
std::ostream& operator<<(std::ostream& out, std::pair<F, S*> p) {
    return out << '(' << p.first << ", " << *p.second << ')';
}
template <class F, class S>
std::ostream& operator<<(std::ostream& out, std::pair<F*, S> p) {
    return out << '(' << *p.first << ", " << p.second << ')';
}
template <class F, class S>
std::ostream& operator<<(std::ostream& out, std::pair<F*, S*> p) {
    return out << '(' << *p.first << ", " << *p.second << ')';
}

std::ostream& operator<<(std::ostream& out, std::set<int> s) {
    out << '{';
    if(s.size() > 0) {
        if(*s.begin() == INF) {
            out << "-";
        }
        else {
            out << *s.begin();
        }
        for(auto index = ++s.begin(); index != s.end(); index++) {
            if(*index == INF) {
                out << ", -";
            }
            else {
                out << ", " << *index;
            }
        }
    }
    return out << '}';
}
template <class T>
std::ostream& operator<<(std::ostream& out, std::set<T> s) {
    out << '{';
    if(s.size() > 0) {
        out << *s.begin();
        for(auto index = ++s.begin(); index != s.end(); index++) {
            out << ", " << *index;
        }
    }
    return out << '}';
}

std::ostream& operator<<(std::ostream& out, std::unordered_set<int> s) {
    out << '{';
    if(s.size() > 0) {
        if(*s.begin() == INF) {
            out << "-";
        }
        else {
            out << *s.begin();
        }
        for(auto index = ++s.begin(); index != s.end(); index++) {
            if(*index == INF) {
                out << ", -";
            }
            else {
                out << ", " << *index;
            }
        }
    }
    return out << '}';
}
template <class T>
std::ostream& operator<<(std::ostream& out, std::unordered_set<T> s) {
    out << '{';
    if(s.size() > 0) {
        out << *s.begin();
        for(auto index = ++s.begin(); index != s.end(); index++) {
            out << ", " << *index;
        }
    }
    return out << '}';
}

std::ostream& operator<<(std::ostream& out, std::vector<int> v) {
    out << '[';
    if(v.size() > 0) {
        if(*v.begin() == INF) {
            out << "-";
        }
        else {
            out << *v.begin();
        }
        for(auto index = ++v.begin(); index != v.end(); index++) {
            if(*index == INF) {
                out << ", -";
            }
            else {
                out << ", " << *index;
            }
        }
    }
    return out << ']';
}
template <class T>
std::ostream& operator<<(std::ostream& out, std::vector<T> v) {
    out << '[';
    if(v.size() > 0) {
        out << *v.begin();
        for(auto index = ++v.begin(); index != v.end(); index++) {
            out << ", " << *index;
        }
    }
    return out << ']';
}

#endif // JM_OSTREAM_H
