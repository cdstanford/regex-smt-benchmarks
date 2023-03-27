;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-9]+\.[0-9]*)|([0-9]*\.[0-9]+)|([0-9]+)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "228.0"
(define-fun Witness1 () String (str.++ "2" (str.++ "2" (str.++ "8" (str.++ "." (str.++ "0" ""))))))
;witness2: "\xAv0.\u0083"
(define-fun Witness2 () String (str.++ "\u{0a}" (str.++ "v" (str.++ "0" (str.++ "." (str.++ "\u{83}" ""))))))

(assert (= regexA (re.union (re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".") (re.* (re.range "0" "9"))))(re.union (re.++ (re.* (re.range "0" "9"))(re.++ (re.range "." ".") (re.+ (re.range "0" "9")))) (re.+ (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
