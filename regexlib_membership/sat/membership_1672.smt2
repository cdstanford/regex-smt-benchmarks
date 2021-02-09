;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d{2}.?\d{3}.?\d{3}/?\d{4}-?\d{2}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "62*988\u008B753/8898-46"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "2" (seq.++ "*" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "\x8b" (seq.++ "7" (seq.++ "5" (seq.++ "3" (seq.++ "/" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "-" (seq.++ "4" (seq.++ "6" "")))))))))))))))))))
;witness2: "\u00AD\u00CEZo89756,699/3729647\u00A7"
(define-fun Witness2 () String (seq.++ "\xad" (seq.++ "\xce" (seq.++ "Z" (seq.++ "o" (seq.++ "8" (seq.++ "9" (seq.++ "7" (seq.++ "5" (seq.++ "6" (seq.++ "," (seq.++ "6" (seq.++ "9" (seq.++ "9" (seq.++ "/" (seq.++ "3" (seq.++ "7" (seq.++ "2" (seq.++ "9" (seq.++ "6" (seq.++ "4" (seq.++ "7" (seq.++ "\xa7" "")))))))))))))))))))))))

(assert (= regexA (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range "/" "/"))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 2 2) (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
