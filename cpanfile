requires 'perl', '5.010001';

requires 'Class::Load', '0.22';
requires 'Class::Accessor::Lite', '0.06';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'Test::UseAllModules', '0.15';
};

