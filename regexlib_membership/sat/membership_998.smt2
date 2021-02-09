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

;witness1: "G-4.4F3.g@C-.L"
(define-fun Witness1 () String (seq.++ "G" (seq.++ "-" (seq.++ "4" (seq.++ "." (seq.++ "4" (seq.++ "F" (seq.++ "3" (seq.++ "." (seq.++ "g" (seq.++ "@" (seq.++ "C" (seq.++ "-" (seq.++ "." (seq.++ "L" "")))))))))))))))
;witness2: "\'\u007F{88@c..o\u00E6"
(define-fun Witness2 () String (seq.++ "'" (seq.++ "\x7f" (seq.++ "{" (seq.++ "8" (seq.++ "8" (seq.++ "@" (seq.++ "c" (seq.++ "." (seq.++ "." (seq.++ "o" (seq.++ "\xe6" ""))))))))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "." ".") (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
