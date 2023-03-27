;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .*[Pp]en[Ii1][\$s].*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u009DpenI$"
(define-fun Witness1 () String (str.++ "\u{9d}" (str.++ "p" (str.++ "e" (str.++ "n" (str.++ "I" (str.++ "$" "")))))))
;witness2: "\u00F4Penis"
(define-fun Witness2 () String (str.++ "\u{f4}" (str.++ "P" (str.++ "e" (str.++ "n" (str.++ "i" (str.++ "s" "")))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.union (re.range "P" "P") (re.range "p" "p"))(re.++ (str.to_re (str.++ "e" (str.++ "n" "")))(re.++ (re.union (re.range "1" "1")(re.union (re.range "I" "I") (re.range "i" "i")))(re.++ (re.union (re.range "$" "$") (re.range "s" "s")) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
