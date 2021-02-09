;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\D{0,2}[0]{0,3}[1]{0,1}\D{0,2}([2-9])(\d{2})\D{0,2}(\d{3})\D{0,2}(\d{3})\D{0,2}(\d{1})\D{0,2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0\u00D19395983805o\u0086"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "\xd1" (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ "5" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "8" (seq.++ "0" (seq.++ "5" (seq.++ "o" (seq.++ "\x86" "")))))))))))))))
;witness2: "b\x6849K=888\u00F9749^0"
(define-fun Witness2 () String (seq.++ "b" (seq.++ "\x06" (seq.++ "8" (seq.++ "4" (seq.++ "9" (seq.++ "K" (seq.++ "=" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "\xf9" (seq.++ "7" (seq.++ "4" (seq.++ "9" (seq.++ "^" (seq.++ "0" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 0 2) (re.union (re.range "\x00" "/") (re.range ":" "\xff")))(re.++ ((_ re.loop 0 3) (re.range "0" "0"))(re.++ (re.opt (re.range "1" "1"))(re.++ ((_ re.loop 0 2) (re.union (re.range "\x00" "/") (re.range ":" "\xff")))(re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ ((_ re.loop 0 2) (re.union (re.range "\x00" "/") (re.range ":" "\xff")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ ((_ re.loop 0 2) (re.union (re.range "\x00" "/") (re.range ":" "\xff")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ ((_ re.loop 0 2) (re.union (re.range "\x00" "/") (re.range ":" "\xff")))(re.++ (re.range "0" "9")(re.++ ((_ re.loop 0 2) (re.union (re.range "\x00" "/") (re.range ":" "\xff"))) (str.to_re "")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
