-module(public_key_ext_SUITE).

-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").

-include_lib("public_key/include/public_key.hrl").

-define(SAMPLE_CSR, <<"-----BEGIN CERTIFICATE REQUEST-----
MIIC6zCCAdMCAQAwgaUxCzAJBgNVBAYTAlBMMRAwDgYDVQQIDAdTaWxlc2lhMRAw
DgYDVQQHDAdHbGl3aWNlMRYwFAYDVQQKDA1QYXR0ZXJuIE1hdGNoMRQwEgYDVQQL
DAtPcGVuIFNvdXJjZTEaMBgGA1UEAwwRcGF0dGVybi1tYXRjaC5jb20xKDAmBgkq
hkiG9w0BCQEWGWNvbnRhY3RAcGF0dGVybi1tYXRjaC5jb20wggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQDFxX+RhJioFT8tWPoBU6W6VBXt98SfGTReNUmw
JD9uR5F6W+8nEEPiKZ21UCK63NBpQB+kXln7T4aqj1O+GdsHoHYS5n7L27yCpmuF
MXtl2ZDVz7QHDd57P9TgcpvdVSwBXYAEF9looARQLzw7bnEVUN01dngBN5N2/D8a
cOZpFTzp4wtjB9ZYmmCBzPm1xoSJskzg8uTVe2LFh8IWqugvZ/gHt6GquJBMjrih
2TSvv11KgR0o5VAeb7zDY+2HDQYDl7EYaRJtKby/c1O7pTLJnvW7B+rkAtZtJzbI
MXj5xvjlGxzdflJbDPAft6sqYkutczNVuJ9vPtKpkuH1sy1BAgMBAAGgADANBgkq
hkiG9w0BAQsFAAOCAQEATGB5coj2iLUjrjbJ+Q6fWImiaJxiRdOJxs1Y3mWUCYyW
a32dITkMQV3Nb54FJe0MT30HdPZu14WLwOdyHxVwVLmsZA3+U99OzVq/kiaE3FFL
l5XAGHD+2qNel7FumC3dAjdpvsAgPsamUZR7i1hJOWnVSuwkrEXis9gRwhOoo7xL
Gaqft+yVnHxUtcOFFQ4TLEFWX6O/ZAUxD5fzHW+u/S9Q2q0deIeG6ZJKOkRw/HbZ
9LFPxu9pPdox0xQ6d1SFVpDiugb2Yfdyh5ZMq6afj6s06IEfyOp7QwzAThI/kBZK
FKAmO4djs2WorD1+WwbwZaXghqhudHpf6aDwMIvCag==
-----END CERTIFICATE REQUEST-----">>).

-export([ all/0 ]).
-export([ happy_path_for_CSR_parsing/1,
          verify_that_CN_is_extracted_properly/1 ]).

all() ->
  [ happy_path_for_CSR_parsing,
    verify_that_CN_is_extracted_properly ].

happy_path_for_CSR_parsing(_Context) ->
  ?assert(is_record(public_key_ext:parse_csr_in_pem_format(?SAMPLE_CSR), 'CertificationRequest')).

verify_that_CN_is_extracted_properly(_Context) ->
  ParsedCSR = public_key_ext:parse_csr_in_pem_format(?SAMPLE_CSR),
  ?assertEqual("pattern-match.com", public_key_ext:extract_CN_from_CSR(ParsedCSR)).
