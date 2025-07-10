;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(eth[0-9]$)|(^eth[0-9]:[1-9]$)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "eth0"
(define-fun Witness1 () String (str.++ "e" (str.++ "t" (str.++ "h" (str.++ "0" "")))))
;witness2: "eth9:9"
(define-fun Witness2 () String (str.++ "e" (str.++ "t" (str.++ "h" (str.++ "9" (str.++ ":" (str.++ "9" "")))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ (str.to_re (str.++ "e" (str.++ "t" (str.++ "h" ""))))(re.++ (re.range "0" "9") (str.to_re "")))) (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "e" (str.++ "t" (str.++ "h" ""))))(re.++ (re.range "0" "9")(re.++ (re.range ":" ":")(re.++ (re.range "1" "9") (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
