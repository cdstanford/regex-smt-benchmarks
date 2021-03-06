;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "x@0G8-"
(define-fun Witness1 () String (seq.++ "x" (seq.++ "@" (seq.++ "0" (seq.++ "G" (seq.++ "8" (seq.++ "-" "")))))))
;witness2: "f.@avx-j-"
(define-fun Witness2 () String (seq.++ "f" (seq.++ "." (seq.++ "@" (seq.++ "a" (seq.++ "v" (seq.++ "x" (seq.++ "-" (seq.++ "j" (seq.++ "-" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
