-module(public_key_ext).

-export([ parse_csr_in_pem_format/1,
          extract_CN_from_CSR/1 ]).

-include_lib("public_key/include/public_key.hrl").

-spec parse_csr_in_pem_format(CSR_PEM :: binary()) -> #'CertificationRequest'{}.
parse_csr_in_pem_format(CSR_PEM) ->
  [{'CertificationRequest', CSR_DER, _}] = public_key:pem_decode(CSR_PEM),
  public_key:der_decode('CertificationRequest', CSR_DER).

-spec is_it_common_name(#'AttributeTypeAndValue'{}) -> boolean().
is_it_common_name(Subject) ->
  Subject#'AttributeTypeAndValue'.type =:= ?'id-at-commonName'.

-spec extract_CN_from_CSR(ParsedCSR :: #'CertificationRequest'{}) -> string() | undefined | multiple_CN_present.
extract_CN_from_CSR(ParsedCSR) ->
  CSRInfo = ParsedCSR#'CertificationRequest'.certificationRequestInfo,
  {rdnSequence, Subjects} = CSRInfo#'CertificationRequestInfo'.subject,
  case lists:filter(fun is_it_common_name/1, lists:flatten(Subjects)) of
    []   -> undefined;
    [CN] -> io_lib_ext:strip_non_printable_characters(binary_to_list(CN#'AttributeTypeAndValue'.value));
    _    -> multiple_CN_present
  end.
