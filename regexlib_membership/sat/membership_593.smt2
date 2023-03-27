;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(sip|sips):.*\@((\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3})|([a-zA-Z\-\.]+\.[a-zA-Z]{2,5}))(:[\d]{1,5})?([\w\-?\@?\;?\,?\=\%\&]+)?
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "sips:@408\u0097898\u008819N039:29588/"
(define-fun Witness1 () String (str.++ "s" (str.++ "i" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "@" (str.++ "4" (str.++ "0" (str.++ "8" (str.++ "\u{97}" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "\u{88}" (str.++ "1" (str.++ "9" (str.++ "N" (str.++ "0" (str.++ "3" (str.++ "9" (str.++ ":" (str.++ "2" (str.++ "9" (str.++ "5" (str.++ "8" (str.++ "8" (str.++ "/" ""))))))))))))))))))))))))))))
;witness2: "sip:@81n9L0\u00A49"
(define-fun Witness2 () String (str.++ "s" (str.++ "i" (str.++ "p" (str.++ ":" (str.++ "@" (str.++ "8" (str.++ "1" (str.++ "n" (str.++ "9" (str.++ "L" (str.++ "0" (str.++ "\u{a4}" (str.++ "9" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (str.++ "s" (str.++ "i" (str.++ "p" "")))) (str.to_re (str.++ "s" (str.++ "i" (str.++ "p" (str.++ "s" ""))))))(re.++ (re.range ":" ":")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "@" "@")(re.++ (re.union (re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) ((_ re.loop 1 3) (re.range "0" "9")))))))) (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "." ".") ((_ re.loop 2 5) (re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.opt (re.++ (re.range ":" ":") ((_ re.loop 1 5) (re.range "0" "9")))) (re.opt (re.+ (re.union (re.range "%" "&")(re.union (re.range "," "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
