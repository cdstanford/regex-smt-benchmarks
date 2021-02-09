;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [B\][a-zA-Z0-9._/ ]+\[/B\]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "c[/B]"
(define-fun Witness1 () String (seq.++ "c" (seq.++ "[" (seq.++ "/" (seq.++ "B" (seq.++ "]" ""))))))
;witness2: "b[/B]W"
(define-fun Witness2 () String (seq.++ "b" (seq.++ "[" (seq.++ "/" (seq.++ "B" (seq.++ "]" (seq.++ "W" "")))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "." "9")(re.union (re.range "A" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "_") (re.range "a" "z"))))))) (str.to_re (seq.++ "[" (seq.++ "/" (seq.++ "B" (seq.++ "]" ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
