;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\n\r)   replacement string---->\n
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "A\u00A4,=\xA\xD   replacement string---->\xA\x1C"
(define-fun Witness1 () String (seq.++ "A" (seq.++ "\xa4" (seq.++ "," (seq.++ "=" (seq.++ "\x0a" (seq.++ "\x0d" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "r" (seq.++ "e" (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "c" (seq.++ "e" (seq.++ "m" (seq.++ "e" (seq.++ "n" (seq.++ "t" (seq.++ " " (seq.++ "s" (seq.++ "t" (seq.++ "r" (seq.++ "i" (seq.++ "n" (seq.++ "g" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ ">" (seq.++ "\x0a" (seq.++ "\x1c" "")))))))))))))))))))))))))))))))))))
;witness2: "\u00E0\xA\xD   replacement string---->\xARC"
(define-fun Witness2 () String (seq.++ "\xe0" (seq.++ "\x0a" (seq.++ "\x0d" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "r" (seq.++ "e" (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "c" (seq.++ "e" (seq.++ "m" (seq.++ "e" (seq.++ "n" (seq.++ "t" (seq.++ " " (seq.++ "s" (seq.++ "t" (seq.++ "r" (seq.++ "i" (seq.++ "n" (seq.++ "g" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ ">" (seq.++ "\x0a" (seq.++ "R" (seq.++ "C" "")))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "\x0a" (seq.++ "\x0d" ""))) (str.to_re (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "r" (seq.++ "e" (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "c" (seq.++ "e" (seq.++ "m" (seq.++ "e" (seq.++ "n" (seq.++ "t" (seq.++ " " (seq.++ "s" (seq.++ "t" (seq.++ "r" (seq.++ "i" (seq.++ "n" (seq.++ "g" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ ">" (seq.++ "\x0a" "")))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
