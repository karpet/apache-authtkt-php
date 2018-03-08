#!/usr/bin/env php
<?php

require_once 'TestMore.php';

plan(3);

require_once 'lib/Apache_AuthTkt.php';

ok( $auth_tkt =new Apache_AuthTkt(array('secret' => 'sekrit')), "new AuthTkt" );
ok( $tkt = $auth_tkt->create_ticket(array('uid' => 'username')), "new tkt using uid" );
if (!ok( $auth_tkt->validate_ticket($tkt), "validate ticket" )) {
    diag( $auth_tkt->get_err() );
}
