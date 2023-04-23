;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =  (mailto\:|(news|(ht|f)tp(s?))\://)(([^[:space:]]+)|([^[:space:]]+)( #([^#]+)#)?) 
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: " ftp://\u00E1 4\u00DA\x1B"
(define-fun Witness1 () String (str.++ " " (str.++ "f" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "\u{e1}" (str.++ " " (str.++ "4" (str.++ "\u{da}" (str.++ "\u{1b}" "")))))))))))))
;witness2: "q ftps://\u00D8\u00EAE #\u00CB# \u00A6"
(define-fun Witness2 () String (str.++ "q" (str.++ " " (str.++ "f" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "\u{d8}" (str.++ "\u{ea}" (str.++ "E" (str.++ " " (str.++ "#" (str.++ "\u{cb}" (str.++ "#" (str.++ " " (str.++ "\u{a6}" "")))))))))))))))))))

(assert (= regexA (re.++ (re.range " " " ")(re.++ (re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "i" (str.++ "l" (str.++ "t" (str.++ "o" (str.++ ":" "")))))))) (re.++ (re.union (str.to_re (str.++ "n" (str.++ "e" (str.++ "w" (str.++ "s" ""))))) (re.++ (re.union (str.to_re (str.++ "h" (str.++ "t" ""))) (re.range "f" "f"))(re.++ (str.to_re (str.++ "t" (str.++ "p" ""))) (re.opt (re.range "s" "s"))))) (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))))(re.++ (re.union (re.+ (re.union (re.range "\u{00}" "Z") (re.range "\u{5c}" "\u{ff}"))) (re.++ (re.+ (re.union (re.range "\u{00}" "Z") (re.range "\u{5c}" "\u{ff}"))) (re.opt (re.++ (str.to_re (str.++ " " (str.++ "#" "")))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{22}") (re.range "$" "\u{ff}"))) (re.range "#" "#")))))) (re.range " " " "))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
