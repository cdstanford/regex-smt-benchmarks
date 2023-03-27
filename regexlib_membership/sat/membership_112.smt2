;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = '/http:\/\/(?:www\.)?blip\.tv\/file\/(\d+).*/'
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\'/http://blip.tv/file/895B/\'"
(define-fun Witness1 () String (str.++ "'" (str.++ "/" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "b" (str.++ "l" (str.++ "i" (str.++ "p" (str.++ "." (str.++ "t" (str.++ "v" (str.++ "/" (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ "/" (str.++ "8" (str.++ "9" (str.++ "5" (str.++ "B" (str.++ "/" (str.++ "'" "")))))))))))))))))))))))))))))
;witness2: "b\u0095\u00C0\'/http://blip.tv/file/99\x1Ab/\'"
(define-fun Witness2 () String (str.++ "b" (str.++ "\u{95}" (str.++ "\u{c0}" (str.++ "'" (str.++ "/" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "b" (str.++ "l" (str.++ "i" (str.++ "p" (str.++ "." (str.++ "t" (str.++ "v" (str.++ "/" (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ "/" (str.++ "9" (str.++ "9" (str.++ "\u{1a}" (str.++ "b" (str.++ "/" (str.++ "'" ""))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "'" (str.++ "/" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))))(re.++ (re.opt (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." ""))))))(re.++ (str.to_re (str.++ "b" (str.++ "l" (str.++ "i" (str.++ "p" (str.++ "." (str.++ "t" (str.++ "v" (str.++ "/" (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ "/" ""))))))))))))))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re (str.++ "/" (str.++ "'" ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
