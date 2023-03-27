;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\n\r)   replacement string---->\n
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "A\u00A4,=\xA\xD   replacement string---->\xA\x1C"
(define-fun Witness1 () String (str.++ "A" (str.++ "\u{a4}" (str.++ "," (str.++ "=" (str.++ "\u{0a}" (str.++ "\u{0d}" (str.++ " " (str.++ " " (str.++ " " (str.++ "r" (str.++ "e" (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "c" (str.++ "e" (str.++ "m" (str.++ "e" (str.++ "n" (str.++ "t" (str.++ " " (str.++ "s" (str.++ "t" (str.++ "r" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ ">" (str.++ "\u{0a}" (str.++ "\u{1c}" "")))))))))))))))))))))))))))))))))))
;witness2: "\u00E0\xA\xD   replacement string---->\xARC"
(define-fun Witness2 () String (str.++ "\u{e0}" (str.++ "\u{0a}" (str.++ "\u{0d}" (str.++ " " (str.++ " " (str.++ " " (str.++ "r" (str.++ "e" (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "c" (str.++ "e" (str.++ "m" (str.++ "e" (str.++ "n" (str.++ "t" (str.++ " " (str.++ "s" (str.++ "t" (str.++ "r" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ ">" (str.++ "\u{0a}" (str.++ "R" (str.++ "C" "")))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "\u{0a}" (str.++ "\u{0d}" ""))) (str.to_re (str.++ " " (str.++ " " (str.++ " " (str.++ "r" (str.++ "e" (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "c" (str.++ "e" (str.++ "m" (str.++ "e" (str.++ "n" (str.++ "t" (str.++ " " (str.++ "s" (str.++ "t" (str.++ "r" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ ">" (str.++ "\u{0a}" "")))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
