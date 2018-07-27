import redis
import random

r = redis.StrictRedis(host='localhost', port=6379, charset="utf-8", decode_responses=True, db=0)

val = 0
c1 = 0
c2 = 0
c3 = 0

while val <= 10000:
    vl1 = random.randint(1,3)
    cdt = 'candidato'+str(vl1)
    
    r.set(cdt,0)

    r.set(str(vl1),cdt)
    r.incr(cdt)

    if vl1 == 1:
        c1+=1
    elif vl1 == 2:
        c2+=1
    else:
        c3+=1    
   
    val +=1

print('Candidato 1 %s' % c1)
print('Candidato 2 %s' % c2)
print('Candidato 3 %s' % c3)