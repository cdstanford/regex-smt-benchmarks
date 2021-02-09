;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^~/[0-9a-zA-Z_][0-9a-zA-Z/_-]*\.[0-9a-zA-Z_-]+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "~/8O.-"
(define-fun Witness1 () String (seq.++ "~" (seq.++ "/" (seq.++ "8" (seq.++ "O" (seq.++ "." (seq.++ "-" "")))))))
;witness2: "~/4.-"
(define-fun Witness2 () String (seq.++ "~" (seq.++ "/" (seq.++ "4" (seq.++ "." (seq.++ "-" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "~" (seq.++ "/" "")))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
