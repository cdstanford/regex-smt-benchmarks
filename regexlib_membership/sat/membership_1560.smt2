;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .*[Vv][Ii1]agr.*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0091vIagr\x1F\x16\x15\u00DE"
(define-fun Witness1 () String (seq.++ "\x91" (seq.++ "v" (seq.++ "I" (seq.++ "a" (seq.++ "g" (seq.++ "r" (seq.++ "\x1f" (seq.++ "\x16" (seq.++ "\x15" (seq.++ "\xde" "")))))))))))
;witness2: "v1agr\u00A51\x1EG\u009B"
(define-fun Witness2 () String (seq.++ "v" (seq.++ "1" (seq.++ "a" (seq.++ "g" (seq.++ "r" (seq.++ "\xa5" (seq.++ "1" (seq.++ "\x1e" (seq.++ "G" (seq.++ "\x9b" "")))))))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.union (re.range "V" "V") (re.range "v" "v"))(re.++ (re.union (re.range "1" "1")(re.union (re.range "I" "I") (re.range "i" "i")))(re.++ (str.to_re (seq.++ "a" (seq.++ "g" (seq.++ "r" "")))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
