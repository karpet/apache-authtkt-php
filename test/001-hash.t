#!/usr/bin/env php
<?php

require_once 'TestMore.php';

plan(12);

require_once 'lib/Apache_AuthTkt.php';

$digests = array('md5', 'sha1', 'SHA256', 'sHa512');
$last_tkt = '';
foreach ($digests as $digest) {
    ok( $auth_tkt =new Apache_AuthTkt(array('secret' => 'sekrit', 'digest_type' => $digest)), "new $digest AuthTkt" );
    ok( $tkt = $auth_tkt->create_ticket(array('uid' => 'user')), "new tkt" );
    cmp_ok( strlen($tkt), '>', strlen($last_tkt), "each digest makes longer ticket" );
    $last_tkt = $tkt;

    if (!ok( $auth_tkt->validate_ticket($tkt), "validate ticket $digest" )) {
      diag( $auth_tkt->get_err() );
    }
    diag_dump($auth_tkt);
}
