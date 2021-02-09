;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \<img ((src|height|width|border)=:q:Wh*)*/\>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x11<img border=:q:Wborder=:q:Wborder=:q:W/>"
(define-fun Witness1 () String (seq.++ "\x11" (seq.++ "<" (seq.++ "i" (seq.++ "m" (seq.++ "g" (seq.++ " " (seq.++ "b" (seq.++ "o" (seq.++ "r" (seq.++ "d" (seq.++ "e" (seq.++ "r" (seq.++ "=" (seq.++ ":" (seq.++ "q" (seq.++ ":" (seq.++ "W" (seq.++ "b" (seq.++ "o" (seq.++ "r" (seq.++ "d" (seq.++ "e" (seq.++ "r" (seq.++ "=" (seq.++ ":" (seq.++ "q" (seq.++ ":" (seq.++ "W" (seq.++ "b" (seq.++ "o" (seq.++ "r" (seq.++ "d" (seq.++ "e" (seq.++ "r" (seq.++ "=" (seq.++ ":" (seq.++ "q" (seq.++ ":" (seq.++ "W" (seq.++ "/" (seq.++ ">" ""))))))))))))))))))))))))))))))))))))))))))
;witness2: "\u00E3<img />j"
(define-fun Witness2 () String (seq.++ "\xe3" (seq.++ "<" (seq.++ "i" (seq.++ "m" (seq.++ "g" (seq.++ " " (seq.++ "/" (seq.++ ">" (seq.++ "j" ""))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "<" (seq.++ "i" (seq.++ "m" (seq.++ "g" (seq.++ " " ""))))))(re.++ (re.* (re.++ (re.union (str.to_re (seq.++ "s" (seq.++ "r" (seq.++ "c" ""))))(re.union (str.to_re (seq.++ "h" (seq.++ "e" (seq.++ "i" (seq.++ "g" (seq.++ "h" (seq.++ "t" "")))))))(re.union (str.to_re (seq.++ "w" (seq.++ "i" (seq.++ "d" (seq.++ "t" (seq.++ "h" "")))))) (str.to_re (seq.++ "b" (seq.++ "o" (seq.++ "r" (seq.++ "d" (seq.++ "e" (seq.++ "r" ""))))))))))(re.++ (str.to_re (seq.++ "=" (seq.++ ":" (seq.++ "q" (seq.++ ":" (seq.++ "W" "")))))) (re.* (re.range "h" "h"))))) (str.to_re (seq.++ "/" (seq.++ ">" "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
