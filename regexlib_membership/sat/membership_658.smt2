;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ~[A-Z][a-z]+(b|ch|d|g|j|k|l|m|n|p|r|s|t|v|z)(ian)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "k\u00E5\x11\u00AE~Iegzchian"
(define-fun Witness1 () String (str.++ "k" (str.++ "\u{e5}" (str.++ "\u{11}" (str.++ "\u{ae}" (str.++ "~" (str.++ "I" (str.++ "e" (str.++ "g" (str.++ "z" (str.++ "c" (str.++ "h" (str.++ "i" (str.++ "a" (str.++ "n" "")))))))))))))))
;witness2: "~Jxbian"
(define-fun Witness2 () String (str.++ "~" (str.++ "J" (str.++ "x" (str.++ "b" (str.++ "i" (str.++ "a" (str.++ "n" ""))))))))

(assert (= regexA (re.++ (re.range "~" "~")(re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.union (re.range "b" "b")(re.union (str.to_re (str.++ "c" (str.++ "h" ""))) (re.union (re.range "d" "d")(re.union (re.range "g" "g")(re.union (re.range "j" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "t")(re.union (re.range "v" "v") (re.range "z" "z")))))))))(re.++ (str.to_re (str.++ "i" (str.++ "a" (str.++ "n" "")))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
