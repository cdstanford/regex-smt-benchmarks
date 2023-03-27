;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-z\.]*\s?([a-z\-\']+\s)+[a-z\-\']+$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-\x9z"
(define-fun Witness1 () String (str.++ "-" (str.++ "\u{09}" (str.++ "z" ""))))
;witness2: " x v-\'-\x9x\xD----"
(define-fun Witness2 () String (str.++ " " (str.++ "x" (str.++ " " (str.++ "v" (str.++ "-" (str.++ "'" (str.++ "-" (str.++ "\u{09}" (str.++ "x" (str.++ "\u{0d}" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "." ".") (re.range "a" "z")))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.++ (re.+ (re.union (re.range "'" "'")(re.union (re.range "-" "-") (re.range "a" "z")))) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ (re.+ (re.union (re.range "'" "'")(re.union (re.range "-" "-") (re.range "a" "z")))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
