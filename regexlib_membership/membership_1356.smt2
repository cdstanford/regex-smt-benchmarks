;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \.txt$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "}.txt"
(define-fun Witness1 () String (str.++ "}" (str.++ "." (str.++ "t" (str.++ "x" (str.++ "t" ""))))))
;witness2: "\u00AC\x16.txt"
(define-fun Witness2 () String (str.++ "\u{ac}" (str.++ "\u{16}" (str.++ "." (str.++ "t" (str.++ "x" (str.++ "t" "")))))))

(assert (= regexA (re.++ (str.to_re (str.++ "." (str.++ "t" (str.++ "x" (str.++ "t" ""))))) (str.to_re ""))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
