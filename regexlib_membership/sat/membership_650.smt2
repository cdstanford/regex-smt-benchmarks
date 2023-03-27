;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d)(\.)(\d)+\s(x)\s(10)(e|E|\^)(-)?(\d)+$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "4.7\xCx\u00A010^-49"
(define-fun Witness1 () String (str.++ "4" (str.++ "." (str.++ "7" (str.++ "\u{0c}" (str.++ "x" (str.++ "\u{a0}" (str.++ "1" (str.++ "0" (str.++ "^" (str.++ "-" (str.++ "4" (str.++ "9" "")))))))))))))
;witness2: "8.90\xDx\u008510e-381"
(define-fun Witness2 () String (str.++ "8" (str.++ "." (str.++ "9" (str.++ "0" (str.++ "\u{0d}" (str.++ "x" (str.++ "\u{85}" (str.++ "1" (str.++ "0" (str.++ "e" (str.++ "-" (str.++ "3" (str.++ "8" (str.++ "1" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "0" "9")(re.++ (re.range "." ".")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.range "x" "x")(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (str.to_re (str.++ "1" (str.++ "0" "")))(re.++ (re.union (re.range "E" "E")(re.union (re.range "^" "^") (re.range "e" "e")))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.+ (re.range "0" "9")) (str.to_re ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
