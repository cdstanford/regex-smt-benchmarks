;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<scheme>[a-zA-Z][a-zA-Z0-9\+\-\.]*):(?://(?:(?<username>(?:[a-zA-Z0-9_~!&',;=\.\-\$\(\)\*\+]|(?:%[0-9a-fA-F]{2}))+):?(?:[a-zA-Z0-9_~!&',;=\.\-\$\(\)\*\+]|(?:%[0-9a-fA-F]{2}))*@)?(?<host>(?:[a-zA-Z0-9_~!&',;=\.\-\$\(\)\*\+]|(?:%[0-9a-fA-F]{2}))*)(?::(?<port>[0-9]*))?(?<path>(?:/(?:[a-zA-Z0-9_~!&',;=:@\.\-\$\(\)\*\+]|(?:%[0-9a-fA-F]{2}))*)*)|(?<path>/(?:(?:[a-zA-Z0-9_~!&',;=:@\.\-\$\(\)\*\+]|(?:%[0-9a-fA-F]{2}))+(?:/(?:[a-zA-Z0-9_~!&',;=:@\.\-\$\(\)\*\+]|(?:%[0-9a-fA-F]{2}))*)*)?)|(?<path>(?:[a-zA-Z0-9_~!&',;=:@\.\-\$\(\)\*\+]|(?:%[0-9a-fA-F]{2}))+(?:/(?:[a-zA-Z0-9_~!&',;=:@\.\-\$\(\)\*\+]|(?:%[0-9a-fA-F]{2}))*)*))?(?:\?(?<query>(?:[a-zA-Z0-9_~!&',;=:@/?\.\-\$\(\)\*\+]|(?:%[0-9a-fA-F]{2}))*))?(?:\#(?<fragment>(?:[a-zA-Z0-9_~!&',;=:@/?\.\-\$\(\)\*\+]|(?:%[0-9a-fA-F]{2}))*))?
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Sh:%378R"
(define-fun Witness1 () String (str.++ "S" (str.++ "h" (str.++ ":" (str.++ "%" (str.++ "3" (str.++ "7" (str.++ "8" (str.++ "R" "")))))))))
;witness2: "\x17T:%E9%d0+%d1/M%9a"
(define-fun Witness2 () String (str.++ "\u{17}" (str.++ "T" (str.++ ":" (str.++ "%" (str.++ "E" (str.++ "9" (str.++ "%" (str.++ "d" (str.++ "0" (str.++ "+" (str.++ "%" (str.++ "d" (str.++ "1" (str.++ "/" (str.++ "M" (str.++ "%" (str.++ "9" (str.++ "a" "")))))))))))))))))))

(assert (= regexA (re.++ (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.* (re.union (re.range "+" "+")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))(re.++ (re.range ":" ":")(re.++ (re.opt (re.union (re.++ (str.to_re (str.++ "/" (str.++ "/" "")))(re.++ (re.opt (re.++ (re.+ (re.union (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "&" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~")))))))))) (re.++ (re.range "%" "%") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))(re.++ (re.opt (re.range ":" ":"))(re.++ (re.* (re.union (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "&" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~")))))))))) (re.++ (re.range "%" "%") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))) (re.range "@" "@")))))(re.++ (re.* (re.union (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "&" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~")))))))))) (re.++ (re.range "%" "%") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))(re.++ (re.opt (re.++ (re.range ":" ":") (re.* (re.range "0" "9")))) (re.* (re.++ (re.range "/" "/") (re.* (re.union (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "&" ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))) (re.++ (re.range "%" "%") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))))))))(re.union (re.++ (re.range "/" "/") (re.opt (re.++ (re.+ (re.union (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "&" ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))) (re.++ (re.range "%" "%") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))) (re.* (re.++ (re.range "/" "/") (re.* (re.union (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "&" ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))) (re.++ (re.range "%" "%") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))))))) (re.++ (re.+ (re.union (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "&" ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))) (re.++ (re.range "%" "%") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))) (re.* (re.++ (re.range "/" "/") (re.* (re.union (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "&" ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))) (re.++ (re.range "%" "%") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))))))))(re.++ (re.opt (re.++ (re.range "?" "?") (re.* (re.union (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "&" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~")))))))) (re.++ (re.range "%" "%") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))))) (re.opt (re.++ (re.range "#" "#") (re.* (re.union (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "&" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~")))))))) (re.++ (re.range "%" "%") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
