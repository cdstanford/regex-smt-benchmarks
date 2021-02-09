;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "99@-78.--y_"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "9" (seq.++ "@" (seq.++ "-" (seq.++ "7" (seq.++ "8" (seq.++ "." (seq.++ "-" (seq.++ "-" (seq.++ "y" (seq.++ "_" ""))))))))))))
;witness2: "_8lAD9Z_ZI@-TM.p8\x18"
(define-fun Witness2 () String (seq.++ "_" (seq.++ "8" (seq.++ "l" (seq.++ "A" (seq.++ "D" (seq.++ "9" (seq.++ "Z" (seq.++ "_" (seq.++ "Z" (seq.++ "I" (seq.++ "@" (seq.++ "-" (seq.++ "T" (seq.++ "M" (seq.++ "." (seq.++ "p" (seq.++ "8" (seq.++ "\x18" "")))))))))))))))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "." ".") (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
