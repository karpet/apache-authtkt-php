#!/usr/bin/env php
<?php

require_once 'TestMore.php';

plan(16);

require_once 'lib/Apache_AuthTkt.php';

$digests = array('md5', 'sha1', 'SHA256', 'sHa512');
$last_tkt = '';
foreach ($digests as $digest) {
    ok( $auth_tkt =new Apache_AuthTkt(array('secret' => 'sekrit', 'digest_type' => $digest)), "new $digest AuthTkt" );
    ok( $tkt = $auth_tkt->create_ticket(array('user' => 'username')), "new tkt" );
    cmp_ok( strlen($tkt), '>', strlen($last_tkt), "each digest makes longer ticket" );
    $last_tkt = $tkt;

    if (!ok( $auth_tkt->validate_ticket($tkt), "validate ticket $digest" )) {
      diag( $auth_tkt->get_err() );
    }
}
