#!/bin/bash

keymake.exp

#for h in ldap1 ldap2 kdc1 kdc2 client ldapadmin
for h in ldap1 ldap2 kdc1 kdc2 client
do
    keydeploy.exp root $h
done
