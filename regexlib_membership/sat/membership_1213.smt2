;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(eth[0-9]$)|(^eth[0-9]:[1-9]$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "eth0"
(define-fun Witness1 () String (seq.++ "e" (seq.++ "t" (seq.++ "h" (seq.++ "0" "")))))
;witness2: "eth9:9"
(define-fun Witness2 () String (seq.++ "e" (seq.++ "t" (seq.++ "h" (seq.++ "9" (seq.++ ":" (seq.++ "9" "")))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ (str.to_re (seq.++ "e" (seq.++ "t" (seq.++ "h" ""))))(re.++ (re.range "0" "9") (str.to_re "")))) (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "e" (seq.++ "t" (seq.++ "h" ""))))(re.++ (re.range "0" "9")(re.++ (re.range ":" ":")(re.++ (re.range "1" "9") (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
