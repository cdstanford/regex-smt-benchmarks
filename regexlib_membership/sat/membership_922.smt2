;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \<img ((src|height|width|border)=:q:Wh*)*/\>
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x11<img border=:q:Wborder=:q:Wborder=:q:W/>"
(define-fun Witness1 () String (str.++ "\u{11}" (str.++ "<" (str.++ "i" (str.++ "m" (str.++ "g" (str.++ " " (str.++ "b" (str.++ "o" (str.++ "r" (str.++ "d" (str.++ "e" (str.++ "r" (str.++ "=" (str.++ ":" (str.++ "q" (str.++ ":" (str.++ "W" (str.++ "b" (str.++ "o" (str.++ "r" (str.++ "d" (str.++ "e" (str.++ "r" (str.++ "=" (str.++ ":" (str.++ "q" (str.++ ":" (str.++ "W" (str.++ "b" (str.++ "o" (str.++ "r" (str.++ "d" (str.++ "e" (str.++ "r" (str.++ "=" (str.++ ":" (str.++ "q" (str.++ ":" (str.++ "W" (str.++ "/" (str.++ ">" ""))))))))))))))))))))))))))))))))))))))))))
;witness2: "\u00E3<img />j"
(define-fun Witness2 () String (str.++ "\u{e3}" (str.++ "<" (str.++ "i" (str.++ "m" (str.++ "g" (str.++ " " (str.++ "/" (str.++ ">" (str.++ "j" ""))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "<" (str.++ "i" (str.++ "m" (str.++ "g" (str.++ " " ""))))))(re.++ (re.* (re.++ (re.union (str.to_re (str.++ "s" (str.++ "r" (str.++ "c" ""))))(re.union (str.to_re (str.++ "h" (str.++ "e" (str.++ "i" (str.++ "g" (str.++ "h" (str.++ "t" "")))))))(re.union (str.to_re (str.++ "w" (str.++ "i" (str.++ "d" (str.++ "t" (str.++ "h" "")))))) (str.to_re (str.++ "b" (str.++ "o" (str.++ "r" (str.++ "d" (str.++ "e" (str.++ "r" ""))))))))))(re.++ (str.to_re (str.++ "=" (str.++ ":" (str.++ "q" (str.++ ":" (str.++ "W" "")))))) (re.* (re.range "h" "h"))))) (str.to_re (str.++ "/" (str.++ ">" "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
