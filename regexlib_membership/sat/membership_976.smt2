;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{4})\D?(0[1-9]|1[0-2])\D?([12]\d|0[1-9]|3[01])(\D?([01]\d|2[0-3])\D?([0-5]\d)\D?([0-5]\d)?)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "291011V25"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "9" (seq.++ "1" (seq.++ "0" (seq.++ "1" (seq.++ "1" (seq.++ "V" (seq.++ "2" (seq.++ "5" ""))))))))))
;witness2: "996908\u00F729\x1E23\u00E32216"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "9" (seq.++ "6" (seq.++ "9" (seq.++ "0" (seq.++ "8" (seq.++ "\xf7" (seq.++ "2" (seq.++ "9" (seq.++ "\x1e" (seq.++ "2" (seq.++ "3" (seq.++ "\xe3" (seq.++ "2" (seq.++ "2" (seq.++ "1" (seq.++ "6" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x00" "/") (re.range ":" "\xff")))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.opt (re.union (re.range "\x00" "/") (re.range ":" "\xff")))(re.++ (re.union (re.++ (re.range "1" "2") (re.range "0" "9"))(re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.opt (re.++ (re.opt (re.union (re.range "\x00" "/") (re.range ":" "\xff")))(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.opt (re.union (re.range "\x00" "/") (re.range ":" "\xff")))(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x00" "/") (re.range ":" "\xff"))) (re.opt (re.++ (re.range "0" "5") (re.range "0" "9"))))))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
