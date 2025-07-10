;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "99@-78.--y_"
(define-fun Witness1 () String (str.++ "9" (str.++ "9" (str.++ "@" (str.++ "-" (str.++ "7" (str.++ "8" (str.++ "." (str.++ "-" (str.++ "-" (str.++ "y" (str.++ "_" ""))))))))))))
;witness2: "_8lAD9Z_ZI@-TM.p8\x18"
(define-fun Witness2 () String (str.++ "_" (str.++ "8" (str.++ "l" (str.++ "A" (str.++ "D" (str.++ "9" (str.++ "Z" (str.++ "_" (str.++ "Z" (str.++ "I" (str.++ "@" (str.++ "-" (str.++ "T" (str.++ "M" (str.++ "." (str.++ "p" (str.++ "8" (str.++ "\u{18}" "")))))))))))))))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "." ".") (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
