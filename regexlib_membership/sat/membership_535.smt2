;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <link href="../Common/Styles/iLienStyle.css" type="text/css" rel="stylesheet" />
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: " <link href=\"\u0089\x10/Common/Styles/iLienStyle\u00D2css\" type=\"text/css\" rel=\"stylesheet\" />"
(define-fun Witness1 () String (str.++ " " (str.++ "<" (str.++ "l" (str.++ "i" (str.++ "n" (str.++ "k" (str.++ " " (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "=" (str.++ "\u{22}" (str.++ "\u{89}" (str.++ "\u{10}" (str.++ "/" (str.++ "C" (str.++ "o" (str.++ "m" (str.++ "m" (str.++ "o" (str.++ "n" (str.++ "/" (str.++ "S" (str.++ "t" (str.++ "y" (str.++ "l" (str.++ "e" (str.++ "s" (str.++ "/" (str.++ "i" (str.++ "L" (str.++ "i" (str.++ "e" (str.++ "n" (str.++ "S" (str.++ "t" (str.++ "y" (str.++ "l" (str.++ "e" (str.++ "\u{d2}" (str.++ "c" (str.++ "s" (str.++ "s" (str.++ "\u{22}" (str.++ " " (str.++ "t" (str.++ "y" (str.++ "p" (str.++ "e" (str.++ "=" (str.++ "\u{22}" (str.++ "t" (str.++ "e" (str.++ "x" (str.++ "t" (str.++ "/" (str.++ "c" (str.++ "s" (str.++ "s" (str.++ "\u{22}" (str.++ " " (str.++ "r" (str.++ "e" (str.++ "l" (str.++ "=" (str.++ "\u{22}" (str.++ "s" (str.++ "t" (str.++ "y" (str.++ "l" (str.++ "e" (str.++ "s" (str.++ "h" (str.++ "e" (str.++ "e" (str.++ "t" (str.++ "\u{22}" (str.++ " " (str.++ "/" (str.++ ">" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "<link href=\"(\u00A4/Common/Styles/iLienStyle+css\" type=\"text/css\" rel=\"stylesheet\" />"
(define-fun Witness2 () String (str.++ "<" (str.++ "l" (str.++ "i" (str.++ "n" (str.++ "k" (str.++ " " (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "=" (str.++ "\u{22}" (str.++ "(" (str.++ "\u{a4}" (str.++ "/" (str.++ "C" (str.++ "o" (str.++ "m" (str.++ "m" (str.++ "o" (str.++ "n" (str.++ "/" (str.++ "S" (str.++ "t" (str.++ "y" (str.++ "l" (str.++ "e" (str.++ "s" (str.++ "/" (str.++ "i" (str.++ "L" (str.++ "i" (str.++ "e" (str.++ "n" (str.++ "S" (str.++ "t" (str.++ "y" (str.++ "l" (str.++ "e" (str.++ "+" (str.++ "c" (str.++ "s" (str.++ "s" (str.++ "\u{22}" (str.++ " " (str.++ "t" (str.++ "y" (str.++ "p" (str.++ "e" (str.++ "=" (str.++ "\u{22}" (str.++ "t" (str.++ "e" (str.++ "x" (str.++ "t" (str.++ "/" (str.++ "c" (str.++ "s" (str.++ "s" (str.++ "\u{22}" (str.++ " " (str.++ "r" (str.++ "e" (str.++ "l" (str.++ "=" (str.++ "\u{22}" (str.++ "s" (str.++ "t" (str.++ "y" (str.++ "l" (str.++ "e" (str.++ "s" (str.++ "h" (str.++ "e" (str.++ "e" (str.++ "t" (str.++ "\u{22}" (str.++ " " (str.++ "/" (str.++ ">" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "<" (str.++ "l" (str.++ "i" (str.++ "n" (str.++ "k" (str.++ " " (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "=" (str.++ "\u{22}" "")))))))))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (str.to_re (str.++ "/" (str.++ "C" (str.++ "o" (str.++ "m" (str.++ "m" (str.++ "o" (str.++ "n" (str.++ "/" (str.++ "S" (str.++ "t" (str.++ "y" (str.++ "l" (str.++ "e" (str.++ "s" (str.++ "/" (str.++ "i" (str.++ "L" (str.++ "i" (str.++ "e" (str.++ "n" (str.++ "S" (str.++ "t" (str.++ "y" (str.++ "l" (str.++ "e" ""))))))))))))))))))))))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "c" (str.++ "s" (str.++ "s" (str.++ "\u{22}" (str.++ " " (str.++ "t" (str.++ "y" (str.++ "p" (str.++ "e" (str.++ "=" (str.++ "\u{22}" (str.++ "t" (str.++ "e" (str.++ "x" (str.++ "t" (str.++ "/" (str.++ "c" (str.++ "s" (str.++ "s" (str.++ "\u{22}" (str.++ " " (str.++ "r" (str.++ "e" (str.++ "l" (str.++ "=" (str.++ "\u{22}" (str.++ "s" (str.++ "t" (str.++ "y" (str.++ "l" (str.++ "e" (str.++ "s" (str.++ "h" (str.++ "e" (str.++ "e" (str.++ "t" (str.++ "\u{22}" (str.++ " " (str.++ "/" (str.++ ">" ""))))))))))))))))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
