;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:(?:(?:http|ftp|gopher|telnet|news)://)(?:w{3}\.)?(?:[a-zA-Z0-9/;\?&=:\-_\$\+!\*'\(\|\\~\[\]#%\.])+)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "ftp://www.pa:\u00B4"
(define-fun Witness1 () String (str.++ "f" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." (str.++ "p" (str.++ "a" (str.++ ":" (str.++ "\u{b4}" "")))))))))))))))
;witness2: "oftp://-?\u00F7"
(define-fun Witness2 () String (str.++ "o" (str.++ "f" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "-" (str.++ "?" (str.++ "\u{f7}" "")))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" "")))))(re.union (str.to_re (str.++ "f" (str.++ "t" (str.++ "p" ""))))(re.union (str.to_re (str.++ "g" (str.++ "o" (str.++ "p" (str.++ "h" (str.++ "e" (str.++ "r" "")))))))(re.union (str.to_re (str.++ "t" (str.++ "e" (str.++ "l" (str.++ "n" (str.++ "e" (str.++ "t" ""))))))) (str.to_re (str.++ "n" (str.++ "e" (str.++ "w" (str.++ "s" "")))))))))(re.++ (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))(re.++ (re.opt (re.++ ((_ re.loop 3 3) (re.range "w" "w")) (re.range "." "."))) (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "(")(re.union (re.range "*" "+")(re.union (re.range "-" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "]")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "|" "|") (re.range "~" "~")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
