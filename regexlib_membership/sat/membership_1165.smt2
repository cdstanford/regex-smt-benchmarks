;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z|a-z|&amp;]{3}\d{2}((0[1-9]|1[012])(0[1-9]|1\d|2[0-8])|(0[13456789]|1[012])(29|30)|(0[13578]|1[02])31)|([02468][048]|[13579][26])0229)(\w{2})([A|a|0-9]{1})$|^([A-Z|a-z]{4}\d{2}((0[1-9]|1[012])(0[1-9]|1\d|2[0-8])|(0[13456789]|1[012])(29|30)|(0[13578]|1[02])31)|([02468][048]|[13579][26])0229)((\w{2})([A|a|0-9]{1})){0,3}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "600229\u00E4\u00F6A"
(define-fun Witness1 () String (str.++ "6" (str.++ "0" (str.++ "0" (str.++ "2" (str.++ "2" (str.++ "9" (str.++ "\u{e4}" (str.++ "\u{f6}" (str.++ "A" ""))))))))))
;witness2: "320229\u00CE\u00F1|\u00AA\u00B5a"
(define-fun Witness2 () String (str.++ "3" (str.++ "2" (str.++ "0" (str.++ "2" (str.++ "2" (str.++ "9" (str.++ "\u{ce}" (str.++ "\u{f1}" (str.++ "|" (str.++ "\u{aa}" (str.++ "\u{b5}" (str.++ "a" "")))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (re.++ ((_ re.loop 3 3) (re.union (re.range "&" "&")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "a" "z") (re.range "|" "|"))))))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2"))) (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8")))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1") (re.range "3" "9"))) (re.++ (re.range "1" "1") (re.range "0" "2"))) (re.union (str.to_re (str.++ "2" (str.++ "9" ""))) (str.to_re (str.++ "3" (str.++ "0" ""))))) (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2")))) (str.to_re (str.++ "3" (str.++ "1" "")))))))) (re.++ (re.union (re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8"))))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6")))) (str.to_re (str.++ "0" (str.++ "2" (str.++ "2" (str.++ "9" "")))))))(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "A")(re.union (re.range "a" "a") (re.range "|" "|")))) (str.to_re ""))))) (re.++ (str.to_re "")(re.++ (re.union (re.++ ((_ re.loop 4 4) (re.union (re.range "A" "Z")(re.union (re.range "a" "z") (re.range "|" "|"))))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2"))) (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8")))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1") (re.range "3" "9"))) (re.++ (re.range "1" "1") (re.range "0" "2"))) (re.union (str.to_re (str.++ "2" (str.++ "9" ""))) (str.to_re (str.++ "3" (str.++ "0" ""))))) (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2")))) (str.to_re (str.++ "3" (str.++ "1" "")))))))) (re.++ (re.union (re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8"))))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6")))) (str.to_re (str.++ "0" (str.++ "2" (str.++ "2" (str.++ "9" "")))))))(re.++ ((_ re.loop 0 3) (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.union (re.range "0" "9")(re.union (re.range "A" "A")(re.union (re.range "a" "a") (re.range "|" "|")))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
