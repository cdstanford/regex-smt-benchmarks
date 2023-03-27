;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*(?'num'\d+(\.\d+)?)\s*(?'unit'((w(eek)?)|(wk)|(d(ay)?)|(h(our)?)|(hr))s?)(\s*$)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x97879999.9\xDhour\xA"
(define-fun Witness1 () String (str.++ "\u{09}" (str.++ "7" (str.++ "8" (str.++ "7" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "." (str.++ "9" (str.++ "\u{0d}" (str.++ "h" (str.++ "o" (str.++ "u" (str.++ "r" (str.++ "\u{0a}" "")))))))))))))))))
;witness2: " 38.588 hr"
(define-fun Witness2 () String (str.++ " " (str.++ "3" (str.++ "8" (str.++ "." (str.++ "5" (str.++ "8" (str.++ "8" (str.++ " " (str.++ "h" (str.++ "r" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.++ (re.+ (re.range "0" "9")) (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9")))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.++ (re.union (re.++ (re.range "w" "w") (re.opt (str.to_re (str.++ "e" (str.++ "e" (str.++ "k" ""))))))(re.union (str.to_re (str.++ "w" (str.++ "k" "")))(re.union (re.++ (re.range "d" "d") (re.opt (str.to_re (str.++ "a" (str.++ "y" "")))))(re.union (re.++ (re.range "h" "h") (re.opt (str.to_re (str.++ "o" (str.++ "u" (str.++ "r" "")))))) (str.to_re (str.++ "h" (str.++ "r" ""))))))) (re.opt (re.range "s" "s"))) (re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
