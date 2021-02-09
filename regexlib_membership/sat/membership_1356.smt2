;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \.txt$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "}.txt"
(define-fun Witness1 () String (seq.++ "}" (seq.++ "." (seq.++ "t" (seq.++ "x" (seq.++ "t" ""))))))
;witness2: "\u00AC\x16.txt"
(define-fun Witness2 () String (seq.++ "\xac" (seq.++ "\x16" (seq.++ "." (seq.++ "t" (seq.++ "x" (seq.++ "t" "")))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "." (seq.++ "t" (seq.++ "x" (seq.++ "t" ""))))) (str.to_re ""))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
