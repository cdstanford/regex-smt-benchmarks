;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00CB988888\u00C89038"
(define-fun Witness1 () String (seq.++ "\xcb" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "\xc8" (seq.++ "9" (seq.++ "0" (seq.++ "3" (seq.++ "8" "")))))))))))))
;witness2: "951\u00A4937r8539"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "5" (seq.++ "1" (seq.++ "\xa4" (seq.++ "9" (seq.++ "3" (seq.++ "7" (seq.++ "r" (seq.++ "8" (seq.++ "5" (seq.++ "3" (seq.++ "9" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "\x00" "/") (re.range ":" "\xff")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x00" "/") (re.range ":" "\xff")))(re.++ (re.opt (re.union (re.range "\x00" "/") (re.range ":" "\xff")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x00" "/") (re.range ":" "\xff")))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
