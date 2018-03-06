#!/usr/bin/env php
<?php

require_once 'TestMore.php';

plan(1);

require_once 'lib/Apache_AuthTkt.php';

ok( $auth_tkt = new Apache_AuthTkt(array('secret' => 'sekrit')), "new AuthTkt" );
