;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(sip|sips):.*\@((\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3})|([a-zA-Z\-\.]+\.[a-zA-Z]{2,5}))(:[\d]{1,5})?([\w\-?\@?\;?\,?\=\%\&]+)?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "sips:@408\u0097898\u008819N039:29588/"
(define-fun Witness1 () String (seq.++ "s" (seq.++ "i" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "@" (seq.++ "4" (seq.++ "0" (seq.++ "8" (seq.++ "\x97" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "\x88" (seq.++ "1" (seq.++ "9" (seq.++ "N" (seq.++ "0" (seq.++ "3" (seq.++ "9" (seq.++ ":" (seq.++ "2" (seq.++ "9" (seq.++ "5" (seq.++ "8" (seq.++ "8" (seq.++ "/" ""))))))))))))))))))))))))))))
;witness2: "sip:@81n9L0\u00A49"
(define-fun Witness2 () String (seq.++ "s" (seq.++ "i" (seq.++ "p" (seq.++ ":" (seq.++ "@" (seq.++ "8" (seq.++ "1" (seq.++ "n" (seq.++ "9" (seq.++ "L" (seq.++ "0" (seq.++ "\xa4" (seq.++ "9" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (seq.++ "s" (seq.++ "i" (seq.++ "p" "")))) (str.to_re (seq.++ "s" (seq.++ "i" (seq.++ "p" (seq.++ "s" ""))))))(re.++ (re.range ":" ":")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "@" "@")(re.++ (re.union (re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) ((_ re.loop 1 3) (re.range "0" "9")))))))) (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "." ".") ((_ re.loop 2 5) (re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.opt (re.++ (re.range ":" ":") ((_ re.loop 1 5) (re.range "0" "9")))) (re.opt (re.+ (re.union (re.range "%" "&")(re.union (re.range "," "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
